class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.grouped.where(user_id: current_user.id).order('created_at DESC')
    @external = Transaction.external.where(user_id: current_user.id).order('created_at DESC')
    @total_amount = Transaction.where(user_id: current_user.id).all.sum('amount')
  end

  # GET /transactions/1 or /transactions/1.json
  def show; end

  def group_transactions
    @transactions = Transaction.grouped.where(user_id: current_user.id)
    @total_amount = @transactions.all.sum('amount')
  end

  # rubocop:disable Layout/LineLength
  def stats
    @statistic = Transaction.select('user_id, sum(amount) as total, avg(amount) as average, count(user_id) as number').group('user_id').order('total DESC')
  end

  # rubocop:enable Layout/LineLength
  def external_transactions
    @transactions = Transaction.external.where(user_id: current_user.id)
    @total_amount = @transactions.all.sum('amount')
  end

  # GET /transactions/new
  def new
    @groups = Group.all
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
    @groups = Group.all
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:name, :amount, :user_id, :group_id)
  end
end
